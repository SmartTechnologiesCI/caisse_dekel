pageextension 70033 "Posted Transfer ShptSubformExt" extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Nombre de carton"; rec."Nombre de carton")
            {
                ApplicationArea = All;
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