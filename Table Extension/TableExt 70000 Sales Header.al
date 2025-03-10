tableextension 70000 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(70000; "Montant payé"; Decimal)
        {
            CaptionML = ENU = 'Total Paid amount', FRA = 'Montant total payé';
            FieldClass = FlowField;
            CalcFormula = sum(Encaissement."Montant NET" where("N° commande" = field("No.")));
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'Montant total payé';
        }
        field(70001; "Soldé"; Boolean)
        {
            CaptionML = ENU = 'Fully paid', FRA = 'Soldé';
            /*FieldClass = FlowField;
            CalcFormula = exist("Sales Header" WHERE("No." = field("No."), "Amount Including VAT" = field("Montant payé")));*/
        }
        field(70002; "User ID"; code[50])
        {
            CaptionML = ENU = 'User', FRA = 'Utilisateur';
        }
        field(70004; "Credit"; Boolean)
        {
            CaptionML = ENU = 'Credit', FRA = 'Crédit';
        }
        field(70008; "CreditP"; Boolean)
        {
            CaptionML = ENU = 'Credit', FRA = 'Crédit';
        }
        field(70005; "Valider credit"; Boolean)
        {
            CaptionML = ENU = 'Validate Credit', FRA = 'Valider Crédit';
        }
        field(70006; Timbre; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; TimbreOui; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(70013; "Montant epargne"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70014; epargne; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70015; "Montant unitaire epargne"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70016; "Type epargne"; Option)
        {
            OptionMembers = "CARTON","POIDS";
        }

    }

    var
        myInt: Integer;
        salesline: Record "Sales Line";

    trigger OnDelete()
    var
        purch: record "Purchase Header";
    begin
        // if Rec."Est Echantillone" then begin
        //     purch.Reset();
        //     // purch.SetRange("No.", rec."Contrat origine");
        //     if purch.FindFirst() then begin
        //         purch."Echantillon Douanier" -= 1;
        //         purch.Modify();
        //     end;
        // end;
    end;
}