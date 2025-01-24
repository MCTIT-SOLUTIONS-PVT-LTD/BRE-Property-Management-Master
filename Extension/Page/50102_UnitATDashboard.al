pageextension 50102 UnitManagement extends "O365 Activities"
{
    layout
    {

        modify("Sales This Month")
        {
            Visible = false;
        }
        modify("Overdue Sales Invoice Amount")
        {
            Visible = false;
        }
        modify("Overdue Purch. Invoice Amount")
        {
            Visible = false;
        }
        modify("Ongoing Sales")
        {
            Visible = false;
        }
        modify("Ongoing Purchases")
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify("Incoming Documents")
        {
            Visible = false;
        }

        addafter("Ongoing Sales")
        {
            cuegroup("All")
            {
                Caption = 'All';
                field("All Property"; GetAllPropertiesCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Property';
                    ToolTip = 'Count of all properties.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Property Registration List");
                    end;
                }
                field("All Unit"; GetAllUnitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Unit';
                    ToolTip = 'Count of all units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Item List");
                    end;
                }
            }
            cuegroup("Property Type")
            {
                Caption = 'Property Type';
                field("Residential Property Count"; GetResidentialPropertiesCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Residential property';
                    ToolTip = 'Count of Residential properties.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Residential Property List");
                    end;
                }
                field("Commercial Property Count"; GetCommercialPropertiesCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commercial property';
                    ToolTip = 'Count of Commercial properties.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Commercial Property List");
                    end;
                }
                field("Common Property Count"; GetCommonPropertiesCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Common property';
                    ToolTip = 'Count of Common properties.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Common Property List");
                    end;
                }
            }
            cuegroup("Unit Type")
            {
                Caption = 'Unit Type';
                field("Residential Unit Count"; GetResidentialunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Residential units';
                    ToolTip = 'Count of free units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Residential Unit List");
                    end;
                }
                field("Commercial Unit Count"; GetCommercialunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commercial units';
                    ToolTip = 'Count of free units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Commercial Unit List");
                    end;
                }
                field("Common Unit Count"; GetCommonunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Common units';
                    ToolTip = 'Count of free units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Common Unit List");
                    end;
                }
            }
            cuegroup("Unit Status")
            {
                Caption = 'Unit Status'; // Adjust the caption as needed
                field("Free units Count"; GetFreeunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Free units';
                    ToolTip = 'Count of free units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Free Unit List");
                    end;
                }
                field("Selected units Count"; GetSelectedunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Selected units';
                    ToolTip = 'Count of selected units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Selected Unit List");
                    end;
                }
                field("Occupied units Count"; GetOccupiedunitsCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Occupied units';
                    ToolTip = 'Count of occupied units.';

                    trigger OnDrillDown()
                    begin
                        // Drill down to the vacant property list page
                        PAGE.RUN(PAGE::"Occupied Unit List");
                    end;
                }
            }
        }
    }

    procedure GetAllPropertiesCount(): Integer;
    var
        PropertyRec: Record "Property Registration"; // Replace with your actual Property Table
    begin
        // PropertyRec.SetRange(, 'Residential'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetAllUnitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        // PropertyRec.SetRange(, 'Residential'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetResidentialPropertiesCount(): Integer;
    var
        PropertyRec: Record "Property Registration"; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Property Classification", 'Residential'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetCommercialPropertiesCount(): Integer;
    var
        PropertyRec: Record "Property Registration"; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Property Classification", 'Commercial'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetCommonPropertiesCount(): Integer;
    var
        PropertyRec: Record "Property Registration"; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Property Classification", 'Common'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetResidentialunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Usage Type", 'Residential'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetCommercialunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Usage Type", 'Commercial'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetCommonunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Usage Type", 'Common'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetFreeunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Unit Status", 'Free'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetSelectedunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Unit Status", 'Selected'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;

    procedure GetOccupiedunitsCount(): Integer;
    var
        PropertyRec: Record Item; // Replace with your actual Property Table
    begin
        PropertyRec.SetRange("Unit Status", 'Occupied'); // Filter by Vacant status
        exit(PropertyRec.Count()); // Return the count of vacant properties
    end;
}
