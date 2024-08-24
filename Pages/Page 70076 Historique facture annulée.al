page 70076 "Historique facture annulée"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    Editable = false;
    Caption = 'Historique des factures annulées';
    SourceTableView = where(Cancelled = const(true));
    layout
    {
        area(Content)
        {
            repeater("Liste facture annulee")
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
                field(Cancelled; rec.Cancelled)
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