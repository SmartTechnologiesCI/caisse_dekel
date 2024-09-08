pageextension 70032 "Transfer Order SubformExt" extends "Transfer Order Subform"
{
    layout
    {
        addbefore(Quantity){
            field("Nombre de carton";REC."Nombre de carton"){
                ApplicationArea=All;
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}