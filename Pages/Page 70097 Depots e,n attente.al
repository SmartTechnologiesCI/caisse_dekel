page 70097 "Depots en attente"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Depôt";
    CardPageId = 70014;
    //Editable  = false;;
    // silue samuel 07/03/2025 SourceTableView = where(isBonus = const(false), validated = const(false), DemandeApprobation = const(true), Correction = const(false));
        SourceTableView = where(isBonus = const(false), validated = const(false), Correction = const(false));

    layout
    {
        area(Content)
        {
            repeater("Liste des dépôts")
            {
                field("N°"; "N°")
                {
                    ApplicationArea = All;
                    AssistEdit = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Heure; Heure)
                {
                    ApplicationArea = All;
                }
                field("N° client"; "N° client")
                {
                    ApplicationArea = All;
                }
                field("Nom du client"; "Nom du client")
                {
                    ApplicationArea = All;
                }
                field(Motif; Motif)
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field("Mode de paiement"; "Mode de paiement")
                {
                    ApplicationArea = All;
                }
                field("Code Caisse"; "Code Caisse")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action("Liste des dépôts validés")
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page 70062;
                RunPageView = where(validated = const(true));
            }
        }
    }
    var
        editables: Boolean;
        editablePage: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
        userPerso: record "User Personalization";
    begin
        //SetRange(Date, WorkDate);
        userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            editables := (userPerso."Profile ID" = 'DIRECTEUR');
            CurrPage.Editable := editables;
        end;
        // SetRange(Date, WorkDate);
        rec.SetCurrentKey(Date);
        rec.SetAscending(Date, false);
    end;


    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", rec."N° Client");
        if client.FindFirst() then
            rec."Nom du client" := client.Name;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        if Rec.validated then
            Error('Vous ne pouvez-pas supprimer un dépôt validé');

    end;
}