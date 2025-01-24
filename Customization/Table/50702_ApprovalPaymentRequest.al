table 50702 "Approval Payment Request"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = SystemId, "ID";

    fields
    {
        field(50101; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            // AutoIncrement = true;    
            Editable = false;
            AutoIncrement = true;


        }
        field(50102; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50108; "Request Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Type';
        }

        field(50107; "Tenant ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant ID';
        }
        field(50103; "Proposal ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
        }

        field(50104; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        // field(50105; "Changed Payment Series"; Text[200])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Changed Payment Series';
        // }
        field(50111; "Payment Series"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';
        }
        field(50109; "Change Amount"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Amount';
        }
        field(50112; "change Payment series"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'changed Payment series';
        }
        field(50113; "Payment mode"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment mode';
        }
        field(50114; "Amount"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(50115; "Vat Amount"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vat Amount';
        }
        field(50116; "Deposit Bank"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Bank';
        }
        field(50117; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }
        Field(50110; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
            Editable = true;
        }
    }

    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }



}

