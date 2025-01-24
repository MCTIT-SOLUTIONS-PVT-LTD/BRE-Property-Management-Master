page 50321 "Approval Contract Status List"
{
    PageType = List;
    SourceTable = "Approval Contract Status";
    ApplicationArea = All;
    Caption = 'Approval Request Contract Status List';
    UsageCategory = Lists;
    // CardPageId = 50320;

    InsertAllowed = false;
    ModifyAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;

                    // DrillDown trigger to navigate to the Tenancy Contract Card
                    trigger OnDrillDown()
                    var
                        TenancyContractRec: Record "Tenancy Contract"; // Replace with the correct table name for Tenancy Contract
                    begin
                        // Debugging: Log the Contract ID value
                        Message('Checking Contract ID: %1', Rec."Contract ID");

                        // Use SetRange and FindFirst to locate the record
                        TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");

                        if TenancyContractRec.FindFirst() then begin
                            // Record found, open the Tenancy Contract Card page
                            PAGE.Run(PAGE::"Tenancy Contract Card", TenancyContractRec); // Replace with the correct card page ID or name
                        end else begin
                            // Record not found
                            Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Contract ID");
                        end;
                    end;
                }

                field("Renewal Contract ID"; Rec."Renewal Contract ID")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RenewalContractRec: Record "Contract Renewal"; // Replace with the correct table name for Contract Renewal
                    begin
                        // Debugging: Log the Renewal Contract ID value
                        Message('Checking Renewal Contract ID: %1', Rec."Renewal Contract ID");

                        // Use SetRange and FindFirst to locate the record
                        RenewalContractRec.SetRange("ID", Rec."Renewal Contract ID");

                        if RenewalContractRec.FindFirst() then begin
                            // Record found, open the Contract Renewal Card page
                            PAGE.Run(PAGE::"Contract Renewal Card", RenewalContractRec); // Replace with the correct card page ID or name
                        end else begin
                            // Record not found
                            Message('The selected Contract Renewal ID (%1) does not exist in the Contract Renewal table.', Rec."Renewal Contract ID");
                        end;
                    end;
                }

                field("Lease ID"; Rec."Lease ID")
                {
                    ApplicationArea = All;
                }
                field("Tenancy Contract Status"; Rec."Tenancy Contract Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    SelectedRec: Record "Approval Contract Status";
                begin
                    if Rec.Status = 'Pending' then begin
                        SelectedRec := Rec;
                        SelectedRec.Status := 'Approve';
                        SelectedRec.Modify();
                        Commit();
                        CurrPage.Update();
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;

                trigger OnAction()
                var
                    SelectedRec: Record "Approval Contract Status";
                begin
                    if Rec.Status = 'Pending' then begin
                        SelectedRec := Rec;
                        SelectedRec.Status := 'Declined';
                        SelectedRec.Modify();
                        Commit();
                        CurrPage.Update();
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }
        }

        area(navigation)
        {
            action("Open Tenancy Contract")
            {
                Caption = 'Open Tenancy Contract';
                ApplicationArea = All;
                Image = OpenRecord;

                trigger OnAction()
                var
                    TenancyContractRec: Record "Tenancy Contract"; // Replace with the correct table name for Tenancy Contract
                begin
                    // Debugging: Log the Contract ID value
                    Message('Checking Contract ID: %1', Rec."Contract ID");

                    // Use SetRange and FindFirst to locate the record
                    TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");

                    if TenancyContractRec.FindFirst() then begin
                        // Record found, open the Tenancy Contract Card page
                        PAGE.Run(PAGE::"Tenancy Contract Card", TenancyContractRec); // Replace with the correct card page ID or name
                    end else begin
                        // Record not found
                        Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Contract ID");
                    end;
                end;
            }

            action("Open Renewal Contract")
            {
                Caption = 'Open Renewal Contract';
                ApplicationArea = All;
                Image = OpenRecord;

                trigger OnAction()
                var
                    RenewalContractRec: Record "Contract Renewal"; // Replace with the correct table name for the Renewal Contract
                begin
                    // Debugging: Log the Renewal Contract ID value
                    Message('Checking Renewal Contract ID: %1', Rec."Renewal Contract ID");

                    // Use SetRange and FindFirst to locate the record
                    RenewalContractRec.SetRange("ID", Rec."Renewal Contract ID");

                    if RenewalContractRec.FindFirst() then begin
                        // Record found, open the Renewal Contract Card page
                        PAGE.Run(PAGE::"Contract Renewal Card", RenewalContractRec); // Replace with the correct card page ID or name
                    end else begin
                        // Record not found
                        Message('The selected Renewal Contract ID (%1) does not exist in the Contract Renewal table.', Rec."Renewal Contract ID");
                    end;
                end;
            }
        }
    }
}
