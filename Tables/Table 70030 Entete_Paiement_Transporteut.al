table 70030 Entete_Paiement_Transporteur
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; code_Paiement; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(50001; Palanteur; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transporteur';
        }
        field(50002; Date_Paiement; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Beneficiare; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Caissier; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Caissier/Caissière';
        }
        field(50005; Code_Transporteur; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code transporteur';
        }
        field(5006; Nom_Transporteur; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom Transporteur';
        }
        field(5007; Nom_Planteur; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom planteur';
        }
        field(50008; NumDocExt; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(50029; CNI; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'CARTE NATIONANLE';
        }
        field(50030; Mode_Paiement; Option)
        {
            Caption = 'Mode Paiement';
            DataClassification = ToBeClassified;
            OptionMembers = ESPECE,WAVE,OM,"MTN Money","MOOV Money",CHEQUE;
        }
        field(50031; Observation; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; Telephone; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Archivé';
        }
    }

    keys
    {
        key(Key1; code_Paiement)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}