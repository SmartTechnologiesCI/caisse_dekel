pageextension 70022 "Phys. Inventory JournalEx" extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Qty. (Phys. Inventory)")
        {
            // field("Nombre de carton"; rec."Nombre de carton")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Nombre de carton (calculé)';
            //     Editable=false;
            // }
            //silue samuel 07/03/2025 field("Nombre de cartonc"; rec."Nombre de cartonc")
            // {
            //     ApplicationArea = All;
            //     trigger OnValidate()
            //     begin
            //         // TestField("Phys. Inventory", true);

            //         // if CurrFieldNo <> 0 then begin
            //         //     GetItem();
            //         //     if Item.IsInventoriableType() then
            //         //         WMSManagement.CheckItemJnlLineFieldChange(Rec, xRec, FieldCaption("Qty. (Phys. Inventory)"));
            //         // end;

            //         // "Qty. (Phys. Inventory)" := UOMMgt.RoundAndValidateQty("Qty. (Phys. Inventory)", "Qty. Rounding Precision (Base)", FieldCaption("Qty. (Phys. Inventory)"));

            //         // PhysInvtEntered := true;
            //         REC."Diff Qty carton" := 0;
            //         if REC."Nombre de cartonc" >= REC."Nombre de carton" then begin
            //             // REC.Validate("Entry Type", REC."Entry Type"::"Positive Adjmt.");
            //             // REC.Validate("Diff Qty carton", REC."Nombre de cartonc" - REC."Nombre de carton");
            //             REC."Diff Qty carton" := REC."Nombre de cartonc" - REC."Nombre de carton";
            //         end else begin
            //             // REC.Validate("Entry Type", REC."Entry Type"::"Negative Adjmt.");
            //             // REC.Validate("Diff Qty carton", REC."Nombre de carton" - REC."Nombre de cartonc");
            //             REC."Diff Qty carton" := REC."Nombre de carton" - REC."Nombre de cartonc";
            //         end;
            //         // PhysInvtEntered := false;
            //     end;
            //fin silue samuel 07/03/2025 }
            // field("Diff Qty carton"; rec."Diff Qty carton")
            // {
            //     ApplicationArea = All;

            // }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        tab:Record 83;
        ItemJnlPost: Codeunit "Item Jnl.-Post";
}