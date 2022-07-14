-- load data
data = LOAD 'orders.csv' USING PigStorage(',') AS
(
    game_id: chararray
    unit_id: chararray
    unit_order: chararray
    location: chararray
    target: chararray
    destination: chararray
    success: chararray
    reason: chararray
    turn_number: chararray
)

-- filter data by the target "Holland"
filtered_data = FILTER data BY target == "Holland"

-- group data by location with the target "Holland"
grouped_data = GROUP filtered_data BY(location, target)

-- count how many times Holland was the target of that location
counted_locations = FOREACH grouped_data GENERATE group, COUNT(filtered_data)

-- order data alphabetically
sorted_data = ORDER counted_locations BY $0 ASC

DUMP sorted_data
