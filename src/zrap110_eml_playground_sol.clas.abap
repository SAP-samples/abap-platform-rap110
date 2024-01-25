class ZRAP110_EML_PLAYGROUND_SOL definition
  public
  final
  create public .

public section.

  interfaces IF_OO_ADT_CLASSRUN .
protected section.
private section.
ENDCLASS.



CLASS ZRAP110_EML_PLAYGROUND_SOL IMPLEMENTATION.


METHOD IF_OO_ADT_CLASSRUN~MAIN.
     "declare internal table using derived type
     DATA travel_keys TYPE TABLE FOR READ IMPORT ZRAP110_R_TravelTP_SOL .

     "fill in relevant travel keys for READ request
     travel_keys = VALUE #( ( TravelID = 'xxxx' )
                           "( TravelID = '...' )
                          ).

     "insert your coding here
     "read _travel_ instances for specified key
     READ ENTITIES OF ZRAP110_R_TravelTP_SOL
       ENTITY Travel
*        ALL FIELDS
        FIELDS ( TravelID AgencyID CustomerID BeginDate EndDate )
        WITH travel_keys
    RESULT DATA(lt_travels_read)
    FAILED DATA(failed)
    REPORTED DATA(reported).

    "console output
    out->write( | ***Exercise 10: Implement the Base BO Behavior - Functions*** | ).
*    out->write( lt_travels_read ).
    IF failed IS NOT INITIAL.
      out->write( |- [ERROR] Cause for failed read: { failed-travel[ 1 ]-%fail-cause } | ).
    ENDIF.

    "read relevant booking instances
    READ ENTITIES OF ZRAP110_R_TravelTP_SOL
      ENTITY Travel BY \_Booking
        FROM CORRESPONDING #( lt_travels_read )
        RESULT DATA(lt_bookings_read)
    LINK DATA(travels_to_bookings).

    "execute function getDaysToFlight
    READ ENTITIES OF ZRAP110_R_TravelTP_SOL
      ENTITY Booking
        EXECUTE getDaysToFlight
          FROM VALUE #( FOR link IN travels_to_bookings ( %tky = link-target-%tky ) )
    RESULT DATA(days_to_flight).

    "output result structure
    LOOP AT days_to_flight ASSIGNING FIELD-SYMBOL(<days_to_flight>).
      out->write( | TravelID = { <days_to_flight>-%tky-TravelID } |  ).
      out->write( | BookingID = { <days_to_flight>-%tky-BookingID } | ).
      out->write( | RemainingDaysToFlight  = { <days_to_flight>-%param-remaining_days_to_flight } | ).
      out->write( | InitialDaysToFlight = { <days_to_flight>-%param-initial_days_to_flight } | ).
      out->write( | ---------------           | ).
    ENDLOOP.

ENDMETHOD.
ENDCLASS.
