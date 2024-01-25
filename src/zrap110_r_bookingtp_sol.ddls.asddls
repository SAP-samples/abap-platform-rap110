@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forBooking'
define view entity ZRAP110_R_BOOKINGTP_SOL
  as select from zrap110_abooksol as Booking

  association        to parent ZRAP110_R_TRAVELTP_SOL as _Travel        on  $projection.TravelID = _Travel.TravelID
  association [1..1] to /DMO/I_Customer               as _Customer      on  $projection.CustomerID = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier                as _Carrier       on  $projection.CarrierID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection             as _Connection    on  $projection.CarrierID    = _Connection.AirlineID
                                                                        and $projection.ConnectionID = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight                 as _Flight        on  $projection.CarrierID    = _Flight.AirlineID
                                                                        and $projection.ConnectionID = _Flight.ConnectionID
                                                                        and $projection.FlightDate   = _Flight.FlightDate
  association [1..1] to /DMO/I_Booking_Status_VH      as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus
  association [0..1] to I_Currency                    as _Currency      on  $projection.CurrencyCode = _Currency.Currency
{
  key travel_id             as TravelID,
  key booking_id            as BookingID,
      booking_date          as BookingDate,
      customer_id           as CustomerID,
      carrier_id            as CarrierID,
      connection_id         as ConnectionID,
      flight_date           as FlightDate,
      booking_status        as BookingStatus,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price          as FlightPrice,
      currency_code         as CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //public associations
      _Travel,
      _Customer,
      _Carrier,
      _Connection,
      _Flight,
      _BookingStatus,
      _Currency

}
