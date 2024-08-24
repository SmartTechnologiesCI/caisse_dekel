page 70056 "Liste des encaissements"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Encaissement;
    //Editable = false;
    Caption = 'Liste des encaissements';
    //SourceTableView = where("Validé" = const(false));
    layout
    {
        area(Content)
        {
            repeater("Liste encaissement")
            {
                field("N°"; "N°")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        salesInvoice: record 112;
                    begin
                        salesInvoice.Reset();
                        salesInvoice.SetRange("No.", rec."N° commande");
                        if salesInvoice.FindFirst() then
                            Page.Run(70030, salesInvoice);
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
                field("N° commande"; "N° commande")
                {
                    ApplicationArea = All;
                }
                field("N° client"; "N° client")
                {
                    ApplicationArea = All;
                }
                field("Nom client"; "Nom client")
                {
                    ApplicationArea = All;
                }
                field("Mode de paiement"; "Mode de paiement")
                {
                    ApplicationArea = All;
                }
                field("NET a payer"; "NET a payer")
                {

                }
                field("Montant NET"; "Montant NET")
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field(Monnaie; Monnaie)
                {
                    ApplicationArea = All;
                }

                field("Code caisse"; "Code caisse")
                {
                    ApplicationArea = All;
                }
                /* field("Validé"; "Validé")
                 {
                     ApplicationArea = All;
                 }*/
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
            action("Liste des encaissements validés")
            {
                ApplicationArea = All;
                Image = PostedTimeSheet;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction();
                var
                    encaissement: Record Encaissement;
                begin
                    encaissement.SetRange("Validé", true);
                    encaissement.FindFirst();
                    Page.Run(Page::"Liste des encais. valides", encaissement);
                end;
            }

            // action("Imprimer")
            // {
            //     ApplicationArea = All;
            //     Image = PrintDocument;
            //     Caption = 'Imprimer Tickets';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = prof = 'DIRECTEUR';
            //     trigger OnAction()
            //     var
            //         Encaissement2: Record Encaissement;
            //     begin
            //         Encaissement2.Reset();
            //         Encaissement2.SetRange("N°", "N°");
            //         if (Encaissement2.FindLast()) then
            //             Report.Run(70023, true, false, Encaissement2);
            //     end;
            // }

            action("Imprimer")
            {
                ApplicationArea = All;
                Image = PrintDocument;
                Caption = 'Imprimer Tickets';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Encaissement2: Record Encaissement;
                    direct: Boolean;
                    usersetup: Record "User Setup";
                    SalinvHeader: Record "Sales Invoice Header";
                begin
                    direct := false;
                    if usersetup.Get(UserId) then
                        direct := usersetup.Director;

                    Encaissement2.Reset();
                    Encaissement2.SetRange("N°", Rec."N°");
                    if (Encaissement2.FindLast()) then begin
                        SalinvHeader.SetRange("No.", Encaissement2."N° commande");
                        if SalinvHeader.FindFirst() then
                            if (SalinvHeader.NbImpression = 0) OR (SalinvHeader.Approuve = true) or (direct = true) then begin
                                Report.Run(70023, true, false, Encaissement2);
                                SalinvHeader.Approuve := false;
                                SalinvHeader.Modify();
                            end
                            else
                                Error('Vous n''avez pas le droit de tirer ce rapport, veuillez demander autorisation');
                    end;
                end;
            }


            action("Approbation")
            {
                ApplicationArea = All;
                Image = Approvals;
                Caption = 'Demande Approbation Duplicata';
                Promoted = true;
                PromotedCategory = Process;
                Visible = Not (prof = 'DIRECTEUR');
                trigger OnAction()
                var
                    Encaissement2: Record Encaissement;
                    direct: Boolean;
                    usersetup: Record "User Setup";
                    SalinvHeader: Record "Sales Invoice Header";
                begin

                    Encaissement2.Reset();
                    Encaissement2.SetRange("N°", Rec."N°");
                    if (Encaissement2.FindLast()) then begin
                        SalinvHeader.SetRange("No.", Encaissement2."N° commande");
                        if SalinvHeader.FindFirst() then begin

                            SalinvHeader."Demande approbation" := true;
                            SalinvHeader.Modify();
                            Message('Demande d''approbation envoyée avec succès');
                        end

                    end;
                end;
            }



        }
    }

    var
        userProf: record "User Personalization";
        prof: Text[100];

    trigger OnOpenPage()
    var
        myInt: Integer;
        page: Page 151;
    begin
        //SetRange(Date, WorkDate);
        userProf.SetRange("User ID", UserId);
        if userProf.FindFirst() then
            prof := userProf."Profile ID";

        SetCurrentKey(Date);
        SetAscending(Date, false);
    end;


    trigger OnAfterGetRecord()
    var
        client: record customer;
    begin
        client.SetRange("No.", "N° Client");
        if client.FindFirst() then
            "Nom client" := client.Name;
    end;
}