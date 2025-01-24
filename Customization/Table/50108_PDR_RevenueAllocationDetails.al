table 50108 "PDR Revenue Allocation Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Text[30]) { }
        field(2; "Unit ID"; Code[20]) { }
        field(3; "Sq. Ft."; Decimal) { }
        field(4; "Per Day Rent Per Unit"; Decimal) { }
        field(5; "Total Revenue"; Decimal) { } // Example of additional field
        field(6; "Praposal ID"; Decimal) { } // Example of additional field
    }

    keys
    {
        key(PK; "Year", "Unit ID") { Clustered = true; }
    }
}
