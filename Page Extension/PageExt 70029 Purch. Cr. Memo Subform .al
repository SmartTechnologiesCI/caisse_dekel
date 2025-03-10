pageextension 70029 "Purch. Cr. Memo SubformEXT" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            // field("Lot Qty"; rec."Lot Qty")
            // {
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
       
    }

    var
        myInt: Integer;
        P: Page 52;

    trigger OnOpenPage()
    var
        myInt: Integer;
        PurchInvLine: Record "Purch. Inv. Line";//<<Ligne facture achat enregistré
        // PurchaseLine: Record "Purchase Line";//<<Ligne avoir acaht
        // rec: Record "Purchase Line";
        pp:Page 52;
    begin
        // PurchInvLine.SetRange("Order No.", rec."Order No.");
        // PurchInvLine.SetRange("No.", rec."No.");
        // if PurchInvLine.FindFirst() then begin
        //     rec."Lot Qty" := PurchInvLine."Lot Qty";
        //     rec.Modify();
        //     Message('E:%1 F:%2', rec."No.", rec."Lot Qty");
        // end;
    end;
}