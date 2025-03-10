pageextension 70034 "Posted TransferRcpt SubformExt" extends "Posted Transfer Rcpt. Subform"
{
    layout
    {
        addbefore(Quantity){
            // field("Nombre de carton";rec."Nombre de carton"){
            //     ApplicationArea=All;
            // }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}