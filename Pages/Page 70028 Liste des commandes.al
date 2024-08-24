page 70028 "Liste des factures"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 112;
    //SourceTableView = where(Closed = const(false));
    Editable = false;
    CardPageId = 70030;
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
                        facture.SetRange("No.", "No.");
                        facture.FindFirst();
                        Page.RunModal(70030, facture);
                    end;
                }
                field("Order No."; "Order No.")
                {
                    Caption = 'N° de la commande';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; SystemCreatedAt)
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
                field("Remaining Amount"; "Remaining Amount")
                {
                    Caption = 'Reste à payer';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(ApprouverDuplicata)
            {
                Caption = 'Approuver Duplicata';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    usera: Record "User Setup";
                begin
                    if usera.Get(UserId) then
                        if usera.Director then begin
                            rec."Demande approbation" := false;
                            rec.Approuve := true;
                            rec.Modify();
                            CurrPage.Update();

                        end
                        else
                            Error('Vous n''avez pas le droit d''utiliser cette fonctionnalité');

                end;
            }
            action("Re&lease")
            {
                ApplicationArea = all;
                Caption = 'Rejeter';
                ShortCutKey = 'Ctrl+F11';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SaleInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SaleInvoiceHeader.Reset();
                    SaleInvoiceHeader.SetRange("No.",rec."No.");
                    if SaleInvoiceHeader.FindFirst() then begin
                        SaleInvoiceHeader."Demande approbation":=false;
                        SaleInvoiceHeader.Modify();
                        Message('La demande d''approbaon a été rejeté');
                    end;
                end;
            }

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