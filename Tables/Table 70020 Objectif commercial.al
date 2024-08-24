table 70020 "Objectif Commercial"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Objectif Commercial list";
    LookupPageId = "Objectif Commercial List";


    fields
    {
        field(1; No; Code[50])
        {
            Editable = false;
        }
        field(2; TypeObjectif; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; DateDebut; Date)
        {
            Caption = 'Date Debut';
            DataClassification = ToBeClassified;

        }
        field(4; DateFin; Date)
        {
            Caption = 'Date Fin';
            DataClassification = ToBeClassified;
        }
        field(5; Groupe; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Team.Code;
        }
        field(6; Priority; Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionMembers = Failble,Normal,Haut;
        }
        field(7; Performance; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; isPerformance; Boolean)
        {



        }
        field(9; Status; Option)
        {
            Caption = 'Statut';
            OptionMembers = "En Cours",Termine;
        }

        field(10; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; tailleGroupe; Integer)
        {
            Caption = 'Taille du groupe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Team Salesperson" where("Team Code" = field(Groupe)));

        }
        field(12; "Type de groupe"; Option)
        {
            Caption = 'Type de groupe';
            OptionMembers = Commercial,Peseur;
        }
        field(100; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Editable = false;
        }
        field(101; "Prime du groupe"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; Groupe)
        {

        }


    }

    var
        RMSetup: Record "Marketing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        myInt: Integer;
        usertask: Record "User Task";
        team: Record Team;
        todo: Record "To-do";

    trigger OnInsert()
    begin

        RMSetup.Get();
        IF "No" = '' THEN BEGIN
            NoSeriesMgt.InitSeries(RMSetup."To-do Nos.", xRec."No", TODAY, "No", "No. Series");

        END;

        /*  if (Format(DateDebut) = '') or (Format(DateDebut) = '') then begin
             Error('Une date est necessaire');
         end; */
    end;

    trigger OnModify()
    begin
        /*    if (Format(DateDebut) = '') or (Format(DateDebut) = '') then begin
               Error('Une date est necessaire');
           end; */
    end;

    trigger OnDelete()
    var
        ligneObjectif: Record "Ligne Ojectif Commercial";
    begin
        ligneObjectif.Reset();
        ligneObjectif.SetRange("No Task", Rec.No);
        if ligneObjectif.FindFirst() then begin
            repeat
                ligneObjectif.Delete();
            until ligneObjectif.Next() = 0
        end;
    end;

    trigger OnRename()
    begin

    end;

}