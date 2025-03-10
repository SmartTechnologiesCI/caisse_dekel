tableextension 70002 "Sales invoice Header" extends 112
{

    fields
    {

        field(70001; "Soldé"; Boolean)
        {
            CaptionML = ENU = 'Fully paid', FRA = 'Soldé';
            /*FieldClass = FlowField;
            CalcFormula = exist("Sales Header" WHERE("No." = field("No."), "Amount Including VAT" = field("Montant payé")));*/
        }
        field(70002; "utilisateur"; code[50])
        {
            CaptionML = ENU = 'User', FRA = 'Utilisateur';
        }
        field(70004; "Credit"; Boolean)
        {
            CaptionML = ENU = 'Credit', FRA = 'Crédit';
        }
        field(70006; Timbre; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; TimbreOui; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "CreditP"; Boolean)
        {
            CaptionML = ENU = 'Credit', FRA = 'Crédit';
        }
        field(70009; "Statut Livraison"; Option)
        {
            OptionMembers = "Non payée","Non payée totalement livré","Non payée partiellement livré","Payée Non livré","Payée totalement livré","Payée partiellement livré";
        }
        field(70010; "No_ordre"; Integer)
        {

        }
        field(70011; "Credit exception."; Boolean)
        {
            Caption = 'Crédit exceptionnel';
        }
        field(50033; "Est Echantillone"; Boolean)
        {
            Editable = false;
        }
        field(70012; EpargneOK; Boolean)
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
        field(70017; "Assigned User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70020; "Code preparateur"; Code[50])
        {
            CaptionML = FRA = 'Code du préparateur';
            //  silue samuel 07/03/2025TableRelation = "User App".Nom;
        }
        field(50008; "Preparateur"; Code[50])
        {

        }
        field(50009; "Verificateur"; Code[50])
        {

        }
        field(50010; "facturier"; Boolean)
        {

        }



    } 

    var
        myInt: Integer;

}