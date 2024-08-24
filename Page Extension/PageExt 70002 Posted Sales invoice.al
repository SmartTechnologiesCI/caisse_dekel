pageextension 70002 "PostedSaesInvoice Header" extends 132
{
    layout
    {
        addafter(Closed)
        {
            field("Statut Livraison"; rec."Statut Livraison")
            {
                Editable = enable;
                ApplicationArea = All;
            }
            field(CreditP; rec.CreditP)
            {
                Editable = false;
            }
            field("Credit exception."; rec."Credit exception.")
            {
                Editable = true;
                Visible = directorOrPurchaser;
            }
            /*field(Annulé; Cancelled)
            {
                Editable = true;
            }*/
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter(CreateCreditMemo)
        {
            action(cancelCreditMemo)
            {
                Caption = 'Annuler Facture';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CancelPostedSalesInvoices: Codeunit 70002;
                begin
                    CancelPostedSalesInvoices.CorrectPostedSalesInvoice(Rec);
                end;
            }
            action(createCancelDoc)
            {
                Caption = 'créer annulation';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnACtion()
                var
                    cancelledDoc: record "Cancelled Document";
                begin
                    //cancelCashFlowEntries(SalesInvoiceHeader);
                    cancelledDoc.Reset();
                    cancelledDoc."Source ID" := 112;
                    cancelledDoc."Cancelled Doc. No." := rec."No.";
                    cancelledDoc."Cancelled By Doc. No." := rec."No.";
                    cancelledDoc.Insert();
                    rec.Cancelled := true;
                end;
            }
            action("update category")
            {
                trigger OnAction()
                var
                    article: record item;
                    ligne: record "Sales Invoice Line";
                begin
                    ligne.Reset();
                    if ligne.FindFirst() then begin
                        repeat
                            article.Reset();
                            article.SetRange("No.", ligne."No.");
                            if article.FindFirst() then begin
                                ligne."Item Category Code" := article."Item Category Code";
                                ligne.Modify();
                            end;
                        until ligne.Next = 0;
                        Message('Terminé !');
                    end else
                        Message('Aucune ligne');
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        userPerso: Record "User Personalization";
    begin
        userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            if UserId = 'TULIPE' then
                enable := true
            else
                enable := false;

            if (userPerso."Profile ID" = 'DIRECTEUR') OR (userPerso."Profile ID" = 'SUPERVISEUR ACHAT/STOCK') OR (UserId = 'TULIPE') Then begin
                directorOrPurchaser := true;
            end;
        end
    end;

    var
        enable: Boolean;
        directorOrPurchaser: Boolean;
}