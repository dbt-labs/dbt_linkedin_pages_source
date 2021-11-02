
with base as (

    select * 
    from {{ ref('stg_linkedin_pages__ugc_post_share_statistic_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_linkedin_pages__ugc_post_share_statistic_tmp')),
                staging_columns=get_ugc_post_share_statistic_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        share_statistic_id,
        ugc_post_id
        {{ fivetran_utils.source_relation(
            union_schema_variable='linkedin_pages_union_schemas', 
            union_database_variable='linkedin_pages_union_databases') 
        }}
    from fields
)

select * from final
