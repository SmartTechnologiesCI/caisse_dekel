pageextension 70024 "Sales Return Order SubformX" extends "Sales Return Order Subform"
{
    layout
    {
        modify("Return Qty. Received")
        {
            Editable = true;
        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}