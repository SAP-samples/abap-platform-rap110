CLASS zrap110_calc_trav_elem_sol DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .

    CLASS-METHODS:
      calculate_trav_status_ind
        IMPORTING is_original_data TYPE ZRAP110_C_TravelTP_SOL
        RETURNING VALUE(result)    TYPE ZRAP110_C_TravelTP_SOL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrap110_calc_trav_elem_sol IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    IF it_requested_calc_elements IS INITIAL.
      EXIT.
    ENDIF.

    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_req_calc_elements>).
      CASE <fs_req_calc_elements>.
          "virtual elements from TRAVEL entity
        WHEN 'OVERALLSTATUSINDICATOR'.

          DATA lt_trav_original_data TYPE STANDARD TABLE OF ZRAP110_C_TravelTP_SOL WITH DEFAULT KEY.
          lt_trav_original_data = CORRESPONDING #( it_original_data ).
          LOOP AT lt_trav_original_data ASSIGNING FIELD-SYMBOL(<fs_trav_original_data>).

            <fs_trav_original_data> = zrap110_calc_trav_elem_SOL=>calculate_trav_status_ind( <fs_trav_original_data> ).

          ENDLOOP.

          ct_calculated_data = CORRESPONDING #( lt_trav_original_data ).

      ENDCASE.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity EQ 'ZRAP110_C_TRAVELTP_SOL'. "Travel BO node
      LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_travel_calc_element>).
        CASE <fs_travel_calc_element>.
          WHEN 'OVERALLSTATUSINDICATOR'.
            APPEND 'OVERALLSTATUS' TO et_requested_orig_elements.

        ENDCASE.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
  METHOD calculate_trav_status_ind.
    result = CORRESPONDING #( is_original_data ).

    "travel status indicator
    "(criticality: 1  = red | 2 = orange  | 3 = green)
    CASE result-OverallStatus.
      WHEN 'X'.
        result-OverallStatusIndicator = 1.
      WHEN 'O'.
        result-OverallStatusIndicator = 2.
      WHEN 'A'.
        result-OverallStatusIndicator = 3.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
