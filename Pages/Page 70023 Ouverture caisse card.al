page 70023 "Ouverture caisse card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Ouverture de caisse";
    DeleteAllowed = false;

    Caption = 'Fiche ouverture de caisse';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'N°';
                    AssistEdit = true;
                    Editable = (status <> status::Validated) AND (status <> status::Closed);
                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit_PointCaisse(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Date; rec."Date ouverture")
                {
                    ApplicationArea = All;
                    Caption = 'Date';

                    Editable = (status <> status::Validated) AND (status <> status::Closed);
                }
                field(Heure; rec."Heure ouverture")
                {
                    ApplicationArea = All;
                    Caption = 'Heure';

                    Editable = (status <> status::Validated) AND (status <> status::Closed);
                }
                field("Code caisse"; rec."Code caisse")
                {
                    ApplicationArea = All;
                    Caption = 'Code caisse';

                    Editable = false;
                }
                field("User id"; rec."User id")
                {
                    ApplicationArea = All;
                    Caption = 'Utilisateur';
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Montant';
                    Visible = Billetage;
                    Editable = Billetage AND (status <> status::Validated) AND (status <> status::Closed);
                }
                field(Amount2; rec.Amount2)
                {
                    ApplicationArea = All;
                    Caption = 'Montant';
                    Visible = NOT Billetage;
                    Editable = (status <> status::Validated) AND (status <> status::Closed);
                }
                field(Billetage; Billetage)
                {
                    ApplicationArea = All;
                    Caption = 'Faire Billetage';

                    Editable = (status <> status::Validated) AND (status <> status::Closed);
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Billetage then
                            Amount2 := 0

                    end;
                }
            }

            part("Liste des Billets"; 70024)
            {
                Caption = 'Billets';
                ApplicationArea = All;
                SubPageLink = "N° ouverture" = field("No"), "Code Caisse" = field("Code caisse");
                UpdatePropagation = Both;
                Editable = (status <> status::Validated) AND (status <> status::Closed);
                Visible = Billetage;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Post;
                Enabled = Rec.status = rec.status::Opened;
                trigger OnAction()
                var
                    MouvTransaction: Record Transactions;
                    Mvnt: Record "Mouvements Entrees Sorties";
                begin
                    rec.status := rec.status::Validated;
                    if (Confirm('Voulez-vous enregistrer cette ouverture ?')) then begin
                        MouvTransaction.Reset();
                        MouvTransaction.Source := Source::"Point de caisse";
                        MouvTransaction."Code caisse" := rec."Code caisse";
                        MouvTransaction.Date := rec."Date ouverture";
                        MouvTransaction.Heure := rec."Heure ouverture";
                        MouvTransaction.Description := 'Fond de caisse du ' + format(WorkDate) + ' de ' + format(Time);
                        if (Billetage) then begin
                            MouvTransaction.Montant := rec.Amount;
                            MouvTransaction."Montant recu" := rec.Amount;
                            MouvTransaction."Montant NET" := rec.Amount;
                        end
                        else begin
                            MouvTransaction.Montant := rec.Amount2;
                            MouvTransaction."Montant recu" := rec.Amount2;
                            MouvTransaction."Montant NET" := rec.Amount2;
                        end;
                        MouvTransaction."N° Document" := rec.No;
                        MouvTransaction."Mode de reglement" := 'ESPÈCES';
                        MouvTransaction."user id" := rec."User Id";
                        MouvTransaction."validée" := true;
                        MouvTransaction.Insert();

                        rec.Modify()
                    end;
                end;
            }
            action(Annuler)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Cancel;
                //Visible = false;
                Enabled = (rec.status = rec.status::Opened);
                trigger OnAction()
                var
                    MouvTransaction: Record Transactions;
                    Mvnt: Record "Mouvements Entrees Sorties";
                begin
                    if (Confirm('Voulez-vous annuler cette ouverture ?')) then begin
                        if (Rec.status <> rec.status::Opened) then begin
                            rec.status := rec.status::Opened;
                            MouvTransaction.Reset();
                            MouvTransaction.Source := Source::"Point de caisse";
                            MouvTransaction."Code caisse" := rec."Code caisse";
                            MouvTransaction.Date := rec."Date ouverture";
                            MouvTransaction.Heure := rec."Heure ouverture";
                            MouvTransaction.Description := 'Annulation du fond de caisse du ' + format(rec."Date ouverture") + ' de ' + format(rec."Heure ouverture");
                            if Billetage then begin
                                MouvTransaction.Montant := -rec.Amount;
                                MouvTransaction."Montant NET" := -rec.Amount;
                            end
                            else begin
                                MouvTransaction.Montant := -rec.Amount;
                                MouvTransaction."Montant NET" := -rec.Amount;
                            end;
                            MouvTransaction."Montant recu" := 0;
                            MouvTransaction."N° Document" := rec.No;
                            MouvTransaction."Mode de reglement" := 'ESPÈCES';
                            MouvTransaction."user id" := rec."User Id";
                            MouvTransaction.Insert();
                            rec.Modify()

                        end else
                            Rec.Delete();
                    end


                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        caisse: record caisse;
        OuvertureCaisse: Record "Ouverture de caisse";
    begin
        //OuvertureCaisse.SetRange("Date ouverture", WorkDate);
        caisse.SetRange("User ID", UserId);
        if caisse.FindFirst() then begin
            OuvertureCaisse.SetFilter(status, '=%1|%2', rec.status::Opened, rec.status::Validated);
            OuvertureCaisse.SetFilter("User id", '=%1', UserId);
            if (OuvertureCaisse.FindFirst()) then
                Error('Il existe déjà une ouverture de caisse non clôturée.');

        end
        else
            Error('Vous n''êtes pas configuré en tant que caissier(e)');

    end;

    trigger OnOpenPage()
    begin
        Billetage := false;
    end;

    var
}