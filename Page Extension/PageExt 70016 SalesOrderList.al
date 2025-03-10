pageextension 70016 "SalesOrder_List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnDeleteRecord(): Boolean
    var
        userSetup: Record 91;
    begin
        // if rec."Est Echantillone" then begin
        //     userSetup.Reset();
        //     userSetup.SetRange("User ID", UserId);
        //     userSetup.SetRange(delEchantillon, true);
        //     if NOT userSetup.FindFirst() then
        //         Error('Vous ne pouvez pas supprimer un echantillon douanier. Référez vous à la personne habilitée');
        // end;
    end;


}