{{ config(materialized='table') }}

select ownerid owner_id
      ,ARRAY_AGG(concat(firstname, " ",lastname) ORDER BY _sdc_extracted_at DESC)[OFFSET(0)] AS owner_full_name
FROM `freelance-290006.hubspot.owners`
group by ownerid
