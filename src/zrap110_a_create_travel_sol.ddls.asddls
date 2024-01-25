@EndUserText.label: 'Parameter for Creating Travel+Booking'
define abstract entity ZRAP110_A_CREATE_TRAVEL_SOL
{
  @Consumption.valueHelpDefinition: [ {
    entity      : {
      name      : '/DMO/I_Customer_StdVH',
      element   : 'CustomerID'
    }
  } ]
  customer_id   : /dmo/customer_id;
  @Consumption.valueHelpDefinition: [ {
    entity      : {
      name      : '/DMO/I_Flight_StdVH',
      element   : 'AirlineID'
    },
    additionalBinding: [ {
      localElement: 'flight_date',
      element   : 'FlightDate',
      usage     : #RESULT
    }, {
      localElement: 'connection_id',
      element   : 'ConnectionID',
      usage     : #RESULT
    } ]
  } ]
  carrier_id    : /dmo/carrier_id;
  @Consumption.valueHelpDefinition: [ {
    entity      : {
      name      : '/DMO/I_Flight_StdVH',
      element   : 'AirlineID'
    },
    additionalBinding: [ {
      localElement: 'flight_date',
      element   : 'FlightDate',
      usage     : #RESULT
    }, {
      localElement: 'carrier_id',
      element   : 'AirlineID',
      usage     : #FILTER_AND_RESULT
    } ]
  } ]
  connection_id : /dmo/connection_id;
  @Consumption.valueHelpDefinition: [ {
    entity      : {
      name      : '/DMO/I_Flight_StdVH',
      element   : 'AirlineID'
    },
    additionalBinding: [ {
      localElement: 'carrier_id',
      element   : 'AirlineID',
      usage     : #FILTER_AND_RESULT
    }, {
      localElement: 'connection_id',
      element   : 'ConnectionID',
      usage     : #FILTER_AND_RESULT
    } ]
  } ]
  flight_date   : /dmo/flight_date;

}
