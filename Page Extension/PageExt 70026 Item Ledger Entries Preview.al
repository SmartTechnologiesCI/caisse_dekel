pageextension 70026 "Item Ledger Entries PreviewX" extends "Item Ledger Entries Preview"
{
    layout
    {
        addafter(Quantity)
        {
            field("Lot Qty."; rec."Lot Qty.")
            {
                ApplicationArea = All;
                Caption = 'Nombre de cartons';
            }
            field("Document N°"; "Document N°")
            {
                ApplicationArea = All;
                Caption = 'Document N°';
            }

        }
        addafter("Lot Qty.")
        {
            field("Nombre de cartonc"; rec."Nombre de cartonc")
            {
                ApplicationArea = All;
            }
            field("Diff Qty carton"; "Diff Qty carton")
            {
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
        p: Page 137;
}