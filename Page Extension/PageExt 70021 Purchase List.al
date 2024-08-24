pageextension 70021 "Purchase List" extends "Purchase order List"
{
    layout
    {

    }

    actions
    {
        addlast(Processing)
        {
            action("ExecuteFunction")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = admin;
                trigger OnAction()
                begin
                    setToSold();
                end;
            }
        }

    }
    procedure setToSold()
    var
        pol: Record "Purchase Header";
        paid: Record "Sales Invoice Line";
    begin
        pol.Reset();
        pol.SetFilter(ETA, '<%1', DMY2Date(01, 07, 2022));
        if pol.FindFirst() then begin
            repeat
                pol.Situaion := pol.Situaion::Vendu;
                pol.Modify();

            until pol.Next = 0;
        end;

        paid.Reset();
        paid.SetFilter("Posting Date", '<%1', DMY2Date(01, 07, 2022));
        if paid.FindFirst() then begin
            repeat
                paid."Statut Livraison" := paid."Statut Livraison"::"Payée totalement livré";
                paid.Modify();
            until paid.Next = 0;
        end;
        clear(pol);
        pol.reset();
        pol.SetRange("Prix fixé", true);
        pol.SetFilter(ETA, '>=%1', DMY2Date(01, 07, 2022));
        if pol.FindFirst() then begin
            repeat
                pol.Situaion := pol.Situaion::"for sale";
                pol.Modify();
            until pol.Next = 0;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if UserId = 'TULIPE' then
            admin := true
        else
            admin := false;
    end;

    var
        admin: Boolean;
}