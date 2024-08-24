page 70071 "List livraison"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    Editable = false;
    CardPageId = 70072;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.") { }
                field("Sell-to Customer No."; "Sell-to Customer No.") { }
                field("Sell-to Customer Name"; "Sell-to Customer Name") { }
                field("Due Date"; "Due Date") { }
                field("Statut Livraison"; "Statut Livraison") { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}