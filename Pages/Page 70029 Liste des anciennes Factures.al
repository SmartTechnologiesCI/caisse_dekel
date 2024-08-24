page 70029 "Liste des Factures Ouvertes"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 112;
    SourceTableView = where(Closed = const(false));
    Editable = false;
    Caption = 'Liste des factures partiellements payées ou payées à crédit';
    CardPageId = 70030;
    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field("No."; "No.")
                {
                    Caption = 'N° de la commande';
                    ApplicationArea = All;

                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Caption = 'Client';
                    ApplicationArea = All;

                }
                field(Amount; Amount)
                {
                    Caption = 'Montant hors taxe';
                    ApplicationArea = All;

                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Caption = 'Montant TTC';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetFilter("Order Date", '<%1', WorkDate);
        
        SetCurrentKey("Order Date");
        SetAscending("Order Date", false);
    end;
}