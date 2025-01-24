table 50932 "Revenue Recognition Subpage"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50102; "RR Id"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'RR Id';


        }

        field(50100; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Lease Proposal Details"."Proposal ID";
            Editable = false;

        }
        field(50101; "Tenant Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Id';
            TableRelation = "Lease Proposal Details"."Tenant ID";
            Editable = false; // Make it read-only for the user

        }


        field(50103; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Month';
            Editable = false;

        }



        field(50104; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. of Days';
            Editable = false;

        }



        field(50105; "RR - Method 1 (Day)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR - Method 1 (Day)';

            Editable = false;

        }

        field(50106; "RR - Method 2 (Month)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'RR - Method 2 (Month)';

            Editable = false;

        }

        field(50107; "Total Amount(Day)"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Total Amount(Day)';
            Editable = false;

            FieldClass = FlowField;
            CalcFormula = sum("Revenue Recognition Subpage"."RR - Method 1 (Day)" where("Proposal ID" = field("Proposal ID")));

        }

        field(50108; "Total Amount(Month)"; Decimal)
        {
            // DataClassification = ToBeClassified;
            Caption = 'Total Amount(Month)';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = sum("Revenue Recognition Subpage"."RR - Method 2 (Month)" where("Proposal ID" = field("Proposal ID")));

        }





    }

    keys
    {
        key(PK; "RR ID")
        {
            Clustered = true;
        }


    }

}