page 50121 "PDR Revenue Allocation Grid"
{
    PageType = List;
    SourceTable = "PDR Revenue Allocation Details";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Praposal ID"; Rec."Praposal ID")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LeaseProposal: Record "Lease Proposal Details"; // Assuming Lease Proposal record
                        NewAllocationDetails: Record "PDR Revenue Allocation Details";
                        SingleUnitNames: Text;
                    begin
                        // Fetch the related Lease Proposal record dynamically (assuming there is a relationship between them)
                        if LeaseProposal.Get(Rec."Praposal ID") then begin
                            // Fetch the unit names dynamically from Lease Proposal
                            SingleUnitNames := GetLeaseUnitNames(LeaseProposal);

                            // Set the SingleUnitNames field in the new revenue allocation grid
                            NewAllocationDetails."Unit ID" := SingleUnitNames;

                            // Open the new grid page and pass the NewAllocationDetails record
                            PAGE.Run(PAGE::"PDR Revenue Allocation Grid", NewAllocationDetails);
                        end;
                    end;
                }
                field("Sq. Ft."; Rec."Sq. Ft.")
                {
                    ApplicationArea = All;
                }
                field("Per Day Rent Per Unit"; Rec."Per Day Rent Per Unit")
                {
                    ApplicationArea = All;
                }
                field("Total Revenue"; Rec."Total Revenue")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    //-----------------Get Lease Unit Name -----------------//
    local procedure GetLeaseUnitNames(var LeaseProposal: Record "Lease Proposal Details"): Text
    var
        SingleUnitNamesList: List of [Text];
        Result: Text;
    begin
        // Initialize Result as an empty string
        Result := '';

        // Dynamically fetch unit names related to Lease Proposal
        // This is an example and should be adapted based on how unit names are linked to the Lease Proposal.

        // Assuming the Lease Proposal has a relation to units (could be a list or multiple fields like "UnitName1", "UnitName2", etc.)
        if LeaseProposal."Single Unit Name" <> '' then begin
            if Result <> '' then
                Result := Result + ', '; // Add a comma separator if it's not the first entry
            Result := Result + LeaseProposal."Single Unit Name";
        end;

        if LeaseProposal."Single Unit Name" <> '' then begin
            if Result <> '' then
                Result := Result + ', ';
            Result := Result + LeaseProposal."Single Unit Name";
        end;

        if LeaseProposal."Single Unit Name" <> '' then begin
            if Result <> '' then
                Result := Result + ', ';
            Result := Result + LeaseProposal."Single Unit Name";
        end;

        // If there are many units or a dynamic list, you can loop through the related records

        // Return the concatenated result
        exit(Result);
    end;


    //-----------------Get Lease Unit Name -----------------//
}
