page 70104 "Liste des factures facturier"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 112;
    //SourceTableView = where(Closed = const(false));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field("No."; "No.")
                {
                    Caption = 'N° de la Facture';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        facture: Record 112;
                    begin
                        facture.SetRange("No.", rec."No.");
                        facture.FindFirst();
                        Page.RunModal(70105, facture);
                    end;
                }
                field("Order No."; rec."Order No.")
                {
                    Caption = 'N° de la commande';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemCreatedAt; rec.SystemCreatedAt)
                {
                    Caption = 'Date et heure de la commande';
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
                    Visible = false;
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
        area(Processing)
        {
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;

    begin
        //ETRANGE("Document Date", WorkDate);

        SetCurrentKey("Document Date");
        SetAscending("Document Date", false);
    end;
}