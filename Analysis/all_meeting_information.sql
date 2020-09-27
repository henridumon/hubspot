{{ config(materialized='view') }}


with contacts as (

    select * from {{ref('latest_contact_information')}}
),

meetings as (

    select * from {{ref('latest_meeting_information')}}
),

owners as (

    select * from {{ref('latest_owner_information')}}
)

select contacts.contact_company
       ,contacts.contact_full_name
       ,contacts.contact_country
       ,contacts.contact_state
       ,owners.owner_full_name
       ,meetings.meeting_id
       ,meetings.meeting_duration_minutes
       ,meetings.meeting_date
from meetings
left join owners using (owner_id)
left join contacts using (contact_id)