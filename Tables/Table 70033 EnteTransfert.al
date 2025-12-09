table 70033 EntetTransfert
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; IDTRANSFERT; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(50001; Caissier; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; Caisse; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Caisse."Code caisse";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                AssistEdit_PointCaisse(xRec);
                // rec.Modify();
            end;
        }
        field(50003; Solde; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Code caisse" = field(Caisse)));

        }
        field(50004; NumDocExtern; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(50005; Observation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; DateTransFert; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Transfert';
        }
        field(50007; valide; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "No. Series"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; IDTRANSFERT, NumDocExtern)
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

    procedure AssistEdit_PointCaisse(OldPoint: Record EntetTransfert): Boolean;
    var
        Balance: Record "Parametres caisse";
        TicketPlanteur: Code[100];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Vérifier qu'une balance est sélectionnée
        // Rec.TestField(NU);
        Balance.Get();
        // Balance.SetRange(Code, Rec."Balance Code");
        if not Balance.FindFirst() then
            Error('Renseignement la souche de numéro paie ticket dans paramètre utilisateurs.');
        if NoSeriesMgt.SelectSeries(Balance.NumSouschPaie, OldPoint."No. Series", Rec."No. Series") then begin

            TicketPlanteur :=
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate(), true);

            Rec.NumDocExtern := TicketPlanteur;

            exit(true);
        end else begin
            Error('Impossible de sélectionner la souche de numérotation "%1".', Balance.NumSouschPaie);
        end;
    end;

}