page 70075 "Historique douanier"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    Editable = false;
    Caption = 'Historique des factures douaniere ou veterinaire';
    SourceTableView = where("Est Echantillone" = const(true));
    layout
    {
        area(Content)
        {
            repeater("Liste douaniere")
            {

                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; rec."Remaining Amount") { }
                field(Closed; rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {


        }
    }
}