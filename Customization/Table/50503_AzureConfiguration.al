table 50503 "AzureConfiguration"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50501; Id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50502; "SAS URL"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'SAS URL';
            Editable = true;

        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    //-------------Insert Record---------------------//

    trigger OnInsert()
    var
        AzureConfig: Record AzureConfiguration;
    begin
        // Check if there is already a record in the table
        if AzureConfig.FindFirst() then
            Error('Only one record is allowed in this table.');
    end;

    //-------------Insert Record---------------------//

    var
        myInt: Integer;



}