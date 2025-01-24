page 50931 "Revenue Recognition List"
{
    PageType = List;
    SourceTable = "Revenue Recognition";
    ApplicationArea = All;
    Caption = 'Revenue Recognition List';
    UsageCategory = Lists;
    CardPageId = 50930;


    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("RR Id"; Rec."RR Id")
                {
                    ApplicationArea = All;
                    Caption = 'RR Id';
                }
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Caption = 'Proposal ID';
                }

                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant ID';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Amount';
                }



            }
        }
    }

}
