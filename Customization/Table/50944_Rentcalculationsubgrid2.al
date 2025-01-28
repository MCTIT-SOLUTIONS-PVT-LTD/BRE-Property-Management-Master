table 50944 "Rent Calculation Subpage2"
{
    DataClassification = ToBeClassified;


    fields
    {



        field(50100; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
            Editable = false;

        }

        field(50101; "Installment No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Instalment No.';
            Editable = false;

        }

        field(50102; "Installment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Instalment Start Date';
            Editable = false;


        }
        field(50103; "Installment End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Instalment End Date';
            Editable = false;


        }


        field(50104; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
            Editable = false;



        }

        field(50105; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
            //DecimalPlaces = ;



        }

        // field(50106; "Payment Mode"; Option)
        // {
        //     OptionMembers = Cash,"Bank Transfers","Credit Card",Cheque;
        //     Caption = 'Payment Mode';



        // }

        field(50107; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50108; "RC ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'RC ID';

        }

        // field(50109; "Proposal ID"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Proposal ID';

        // }

        field(50110; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;


        }


        field(50116; "VAT %"; Integer)
        {
            // OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;


        }


        field(50111; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Including VAT';
            Editable = false;


        }

        field(50112; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item Type';
            Editable = false;


        }

        field(50113; "Tenant ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';

        }

        field(50115; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }


        field(50114; "Total Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Rent Calculation Subpage2".Amount where("RC ID" = field("RC ID")));
            // CalcFormula = sum("Payment Schedule2"."Amount Including VAT" where("Proposal ID" = field("Proposal ID"), "Tenant ID" = field("Tenant ID")));
            DecimalPlaces = 0 : 0;
        }


    }


    keys
    {
        key(Key1; "Entry No.", "RC ID")
        {
            Clustered = true;
        }
    }


    // local procedure CalcVATAndTotal()
    // var
    //     vatPer: Integer;
    // begin
    //     if "VAT %" = "VAT %"::"5" then
    //         vatPer := 5
    //     else
    //         vatPer := 0;

    //     "VAT Amount" := Amount * (vatPer / 100);
    //     "Amount Including VAT" := Amount + "VAT Amount";
    // end;




}
