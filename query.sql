select 
o.obs_id,
date_format(o.obs_datetime,'%Y-%m-%dT%h:%i:%s+03:00') as obs_datetime,
o.obs_group_id,
o.encounter_id,
e.encounter_type,
et.uuid as encounter_type_uuid,
o.location_id,
l.uuid as location_uuid,
e.form_id,
f.uuid as form_uuid,
o.person_id,
p.uuid as person_uuid,
p.gender,
date_format(p.birthdate,'%Y-%m-%dT%h:%i:%s+03:00') as birthdate,
o.concept_id,
case 
	when o.value_coded is not null then o.value_coded
	when o.value_numeric is not null then o.value_numeric
    when o.value_datetime is not null then date_format(o.value_datetime,'%Y-%m-%dT%h:%i:%s+03:00')
    when o.value_text is not null then o.value_text
    when o.value_drug is not null then o.value_drug
	when o.value_boolean is not null then o.value_boolean    
    when o.value_complex is not null then o.value_complex
    else null 
end as 'value',
o.value_coded,
o.value_numeric,
date_format(o.value_datetime,'%Y-%m-%dT%h:%i:%s+03:00') as value_datetime,
o.value_text,
o.value_drug,
o.value_boolean,
o.value_complex,
o.uuid,
date_format(o.date_created,'%Y-%m-%dT%h:%i:%s+03:00') as date_created,
o.voided,
date_format(o.date_voided,'%Y-%m-%dT%h:%i:%s+03:00') as date_voided,
o.creator,
o.voided_by
from obs o
join person p on p.person_id = o.person_id
left outer join encounter e on e.encounter_id = o.encounter_id
left outer join location l on l.location_id = o.location_id
left outer join form f on f.form_id = e.form_id
left outer join encounter_type et on et.encounter_type_id = e.encounter_type
where o.voided=0 
order by o.obs_datetime, o.encounter_id
