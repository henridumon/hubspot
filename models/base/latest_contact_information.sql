{{ config(materialized='table') }}

select all_contact_data.vid contact_id
      ,ARRAY_AGG(properties.company.value ORDER BY _sdc_extracted_at DESC)[OFFSET(0)] AS contact_company
      ,ARRAY_AGG(concat(properties.firstname.value, " ",properties.lastname.value) ORDER BY _sdc_extracted_at DESC)[OFFSET(0)] AS contact_full_name
      ,ARRAY_AGG(properties.country.value ORDER BY _sdc_extracted_at DESC)[OFFSET(0)] AS contact_country
      ,ARRAY_AGG(properties.state.value ORDER BY _sdc_extracted_at DESC)[OFFSET(0)] AS contact_state
FROM `{{target.project}}.hubspot.contacts` all_contact_data
group by all_contact_data.vid
