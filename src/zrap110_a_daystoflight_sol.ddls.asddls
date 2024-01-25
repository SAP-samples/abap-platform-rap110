@EndUserText.label: 'Abstract entity for Days To Flight'
define abstract entity ZRAP110_A_DAYSTOFLIGHT_SOL
{
  initial_days_to_flight   : abap.int4;
  remaining_days_to_flight : abap.int4;
  booking_status_indicator : abap.int4;
  days_to_flight_indicator : abap.int4;

}
