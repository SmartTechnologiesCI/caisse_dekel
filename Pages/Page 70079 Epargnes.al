page 70079 "Epargnes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Depôt";
    CardPageId = 70004;
    //Editable  = false;;
    SourceTableView = where(isBonus = const(true));
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
                    Visible = false;
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
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    Visible = false;
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
        editable: Boolean;
        editablePage: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
        userPerso: record "User Personalization";
    begin
        //SetRange(Date, WorkDate);
        userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            editable := (userPerso."Profile ID" = 'DIRECTEUR');
            CurrPage.Editable := editable;
        end;
        // SetRange(Date, WorkDate);
        SetCurrentKey(Date);
        SetAscending(Date, false);
    end;


    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            "Nom du client" := client.Name;
    end;
}