{{ config(materialized='table') }}

with latest_meeting_data as
(
select e.engagement_id, max(_sdc_extracted_at) _sdc_extracted_at
from `{{target.project}}.hubspot.engagements` e
group by e.engagement_id
)

select e.engagement_id meeting_id
      ,value contact_id
      ,DATE(TIMESTAMP_MILLIS(e.metadata.starttime)) meeting_date
      ,(e.metadata.endtime - e.metadata.starttime)/1000 meeting_duration_minutes
      ,e.engagement.ownerid owner_id
FROM `{{target.project}}.hubspot.engagements` e, unnest(e.associations.contactids)
inner join latest_meeting_data 
on latest_meeting_data.engagement_id = e.engagement_id
and latest_meeting_data._sdc_extracted_at = e._sdc_extracted_at
WHERE e.engagement.type = 'MEETING'
