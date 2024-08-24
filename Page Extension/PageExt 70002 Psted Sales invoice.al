/* pageextension 70002 "PostedSaesInvoice Header" extends 132
{
    layout
    {
        addafter(Closed)
        {
            field("Statut Livraison"; "Statut Livraison")
            {
                Editable = enable;
                ApplicationArea = All;
            }
            field(CreditP; CreditP)
            {
                Editable = false;
            }
        }
    }

    actions
    {
        addafter(CorrectInvoice)
        {
            action("Annuler la facture")
            {
                Image = cancel;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CU: Codeunit 70002;
                begin
                    CU.CorrectPostedSalesInvoice(rec);
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
            if userPerso."Profile ID" = 'CONTRÔLEUR' then
                enable := true
            else
                enable := false;
        end
    end;

    var
        enable: Boolean;
} */