tableextension 70006 "Vendor ext" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Total Achat"; Decimal)
        {

            FieldClass = FlowField;
            // CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1')));
            // CalcFormula = sum("Purchase Line"."Amount Including VAT");

        }
        field(70001; ModeleFournisseur; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Templ.".Code;
            Caption = 'Modèle fournisseur';
            trigger OnValidate()
            var
                VendorTemplate: Record "Vendor Templ.";
            begin
                VendorTemplate.SetRange(Code, ModeleFournisseur);
                if VendorTemplate.FindFirst() then begin
                    rec."Gen. Bus. Posting Group" := VendorTemplate."Gen. Bus. Posting Group";
                    rec."VAT Bus. Posting Group" := VendorTemplate."VAT Bus. Posting Group";
                    rec."Vendor Posting Group" := VendorTemplate."Vendor Posting Group";
                    REC.Modify();
                end;
            end;
        }
    }

    var
        myInt: Integer;
}