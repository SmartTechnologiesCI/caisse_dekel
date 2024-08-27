pageextension 70028 "PostedPurch.Cr.Memo SubformExt" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Lot Qty"; rec."Lot Qty")
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
        Pg:Page 44;
}