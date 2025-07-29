create database Airbnb;
use Airbnb;
select * from airbnbdata;
-- -----------------------------------------------------------
-- Identify Common Guest Preferences 1. Room Type Preferences by Country
select country, room_type, COUNT(*) as total_listings from airbnbdata group by country, room_type
order by country, total_listings desc;
/*Interpretation:
Entire Home/Apt is the most preferred choice across all countries, indicating a preference for privacy and larger spaces.
Private Rooms are also popular, particularly in France and Belgium, suggesting demand for affordable stays.
Shared Rooms have minimal preference, indicating privacy concerns or limited supply.  */

-- 2. Stay Duration Preferences
select country, case when minimum_nights <= 7 then'Short-term' when minimum_nights <= 30 then 'Mid-term' else 'Long-term'
    end as stay_type, count(*) as total_listings from airbnbdata group by country, stay_type order by country, total_listings desc;
/*Interpretation:
Short-term Stays dominate in all countries, especially in France and Belgium, indicating a strong preference for vacation or weekend stays.
Mid-term Stays are moderately preferred, particularly in France, suggesting business or temporary relocation needs.
Long-term Stays have minimal demand across all regions, indicating fewer extended stay requirements. */

-- 3. Popular Amenities by Country
select country, count(*) as total_listings, sum(find_in_set('Wifi', amenities) > 0) as wifi_count,
sum(find_in_set('Kitchen', amenities) > 0) as kitchen_count, sum(find_in_set('Washer', amenities) > 0) as washer_count,
sum(find_in_set('Air conditioning', amenities) > 0) as ac_count from airbnbdata group by country order by total_listings desc;
/*Interpretation:
High Amenity Usage: France and Belgium lead in providing amenities, indicating competitive and well-equipped listings.
Basic Amenities Missing: The second column shows zeros, suggesting certain amenities might be unavailable or not reported.
Regional Variation: United States and Germany have fewer listings with amenities, particularly compared to France. */

-- Analyze Guest Reviews and Satisfaction 1. Review Score Segmentation
select country, case when review_scores_rating >= 90 then 'Excellent' when review_scores_rating >= 70 then 'Good'
when review_scores_rating >= 50 then 'Average' else 'Poor' end as review_category, count(*) as total_listings from airbnbdata
where review_scores_rating is not null group by country, review_category order by country, total_listings DESC;
/* Interpretation:
High Satisfaction: Most reviews in all countries fall under the "Excellent" category, indicating overall guest satisfaction.
Moderate Satisfaction: A considerable number of guests rated their experience as "Good", especially in France and Belgium, suggesting opportunities for minor improvements.
Low Satisfaction: "Poor" and "Average" ratings are minimal across all regions, reflecting generally positive experiences. */


-- Price and Review Correlation 1. Average Price Based on Review Scores
select country, round(avg(price), 2) as avg_price, round(avg(review_scores_rating), 2) as avg_review_score
from airbnbdata where review_scores_rating is not null group by country order by avg_review_score desc;
/* Interpretation:
Higher Prices with Higher Scores: In all countries, properties with higher review scores tend to have higher average prices, indicating guests are willing to pay more for better experiences.
U.S. Premium Pricing: The United States has the highest average price ($127.98) with relatively high satisfaction, reflecting a strong market for premium listings.
Affordable Quality in Germany: Germany offers the lowest average price ($54.41) despite good review scores, indicating competitive pricing.
Balanced Pricing in France and Belgium: Both countries maintain a balance between pricing and guest satisfaction. */
/*Final Recommendation
Enhance the availability of short-term rental properties in high-demand tourist regions.
Offer personalized experiences by highlighting amenities that resonate with regional guest preferences.
Promote mid-term stays through corporate partnerships and extended stay discounts.
Assist lower-rated hosts with service improvement programs to boost guest satisfaction and revenue.
Implement region-specific pricing models using review score-based adjustments for maximizing profitability.
These insights and solutions will help Airbnb stakeholders optimize their platform strategy, improve guest experiences, and maximize revenue. */

