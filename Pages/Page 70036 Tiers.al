page 70036 "Liste des Clients"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = customer;
    CardPageId = "Customer Card";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Liste débiteurs")
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;

                }
                field("Balance Due"; rec."Balance Due")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            part("Listes des factures ouvertes"; 70029)
            {
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
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