pageextension 70103 "Create Payment" extends "Create Payment"
{
    layout
    {
        modify("Bank Account"){
            ApplicationArea=All;
            Caption='Moyen de paiement';
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}