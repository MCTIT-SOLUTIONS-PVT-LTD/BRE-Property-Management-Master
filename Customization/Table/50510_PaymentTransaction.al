table 50510 "Payment Transaction"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50501; "PT Id"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(50502; "Tenant Id"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(50503; "Tenant Name"; Text[100])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Tenant Id"))); // Displays Customer Name
        }

        field(50504; "Contract Id"; Integer)
        {

            TableRelation = "Tenancy Contract";
        }

        field(50505; "Approval Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PT Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}