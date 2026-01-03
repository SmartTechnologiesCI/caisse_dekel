page 70078 "Fiche dépot 2"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Depôt;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("N°"; rec."N°")
                {

                    CaptionML = ENU = 'No.', FRA = 'N°';
                    ApplicationArea = All;
                    //Enabled = "Code caisse" <> '';
                    AssistEdit = true;
                    Editable = false;
                    trigger OnAssistEdit()
                    var
                    begin
                        if rec.AssistEdit_depot(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Code caisse"; rec."Code caisse")
                {
                    CaptionML = ENU = 'Cash Register code', FRA = 'Code caisse';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Date)
                {
                    CaptionML = ENU = 'Date', FRA = 'Date';
                    ApplicationArea = All;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Heure; Heure)
                {
                    CaptionML = ENU = 'Time', FRA = 'Heure';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Dépôts")
            {
                Enabled = NOT Validated;
                field("N° client"; "N° client")
                {
                    ApplicationArea = All;
                }

                field("Nom du client"; "Nom du client")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mode de paiement"; "Mode de paiement")
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    CaptionML = ENU = 'Amount', FRA = 'Montant';
                    ApplicationArea = All;
                }
                field(Motif; Motif)
                {
                    CaptionML = ENU = 'Reason', FRA = 'Motif';
                    ApplicationArea = All;
                }
                field(isBonus; isBonus)
                {
                    Caption = 'Epargne';
                }
                /*field(validated; validated)
                {

                }*/
                field("User Id"; rec."User Id")
                {
                    CaptionML = ENU = 'User', FRA = 'Utilisateur';
                    ApplicationArea = All;
                    TableRelation = User."User Name";
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = NOT Validated;
                trigger OnAction()
                var
                    MouvTransaction: record Transactions;
                    reglementEntry3: record 81;
                    reglementEntry2: record 81;
                    reglementEntry: record 81;
                    LineNo: Integer;
                    depot: record "Depôt";
                begin
                    if (Confirm(ConfirmSave)) then begin
                        MouvTransaction.Reset();
                        MouvTransaction.Source := Source::Depot;
                        MouvTransaction."Code caisse" := rec."Code caisse";
                        MouvTransaction.Date := rec.Date;
                        MouvTransaction.Heure := rec.Heure;
                        MouvTransaction.Description := 'Dépôt du client: ' + rec."Nom du client";
                        MouvTransaction.Montant := rec.Montant;
                        MouvTransaction."Montant recu" := rec.Montant;
                        MouvTransaction."Montant NET" := rec.Montant;
                        MouvTransaction."N° Document" := rec."N°";
                        MouvTransaction."Mode de reglement" := rec."Mode de paiement";
                        MouvTransaction."user id" := rec."User Id";
                        MouvTransaction."N° Client" := rec."N° client";
                        MouvTransaction.Insert();
                        rec.Validated := true;
                        rec.Modify();
                        commit();

                        reglementEntry2.SetRange("Journal Template Name", 'REGLEMENT');
                        reglementEntry2.SetRange("Journal Batch Name", Caisse."Code caisse");
                        if (reglementEntry2.FindLast()) then
                            LineNo := reglementEntry2."Line No." + 10000
                        else
                            LineNo := 10000;
                        reglementEntry.Reset();
                        reglementEntry."Journal Template Name" := 'REGLEMENT';
                        reglementEntry.Validate("Journal Template Name");
                        reglementEntry."Journal Batch Name" := Caisse."Code caisse";
                        reglementEntry.Validate("Journal Batch Name");
                        reglementEntry."Line No." := LineNo;
                        reglementEntry."Posting Date" := WorkDate;
                        reglementEntry.Validate("Posting Date");
                        reglementEntry."Document Type" := reglementEntry."Document Type"::Payment;
                        reglementEntry.Validate("Document Type");
                        reglementEntry."Document No." := 'Depot' + rec."N°";
                        reglementEntry.Validate("Document No.");
                        reglementEntry."Account Type" := reglementEntry."Account Type"::"Bank Account";
                        reglementEntry.Validate("Account Type");
                        reglementEntry."Account No." := Caisse."Code caisse";
                        reglementEntry.Validate("Account No.");
                        reglementEntry.Description := 'Dépôt du client: ' + rec."Nom du client";
                        reglementEntry."Bal. Account Type" := reglementEntry."Bal. Account Type"::Customer;
                        reglementEntry."Bal. Account No." := rec."N° client";
                        reglementEntry.Validate("Bal. Account No.");

                        reglementEntry.Amount := rec.Montant;
                        reglementEntry."Amount (LCY)" := rec."Montant";
                        reglementEntry.Validate(Amount);
                        reglementEntry.Validate("Amount (LCY)");
                        reglementEntry."Debit Amount" := rec."Montant";
                        reglementEntry.Validate("Debit Amount");
                        reglementEntry.Insert();

                        reglementEntry3.Reset();
                        reglementEntry3.SetRange("Journal Template Name", 'REGLEMENT');
                        reglementEntry3.SetRange("Journal Batch Name", Caisse."Code caisse");
                        reglementEntry3.SetRange("Document No.", 'Depot' + rec."N°");
                        if (reglementEntry3.FindFirst()) then begin
                            Hide := true;
                            postLedger.OnBeforeCode(reglementEntry3, Hide);
                            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", reglementEntry3);
                        end;
                        Commit();
                        depot.Reset();
                        depot.SetRange("N°", rec."N°");
                        if (depot.FindFirst()) then
                            Report.run(70003, true, true, depot);
                    end;
                end;
            }
            action(Annuler)
            {

                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = NOT Validated;
                trigger OnAction()
                var
                    MouvTransaction: Record "Transactions";
                    Mvnt: Record "Mouvements Entrees Sorties";
                    reglementEntry3: record 81;
                    reglementEntry2: record 81;
                    reglementEntry: record 81;
                    LineNo: Integer;
                begin
                    if (NOT Validated) then begin
                        if (Confirm(cancelSave)) then begin
                            rec.Delete();
                            CurrPage.Close();
                        end;
                    end
                    /*else begin
                        if (Confirm(cancelSave)) then begin
                            MouvTransaction.Reset();
                            MouvTransaction.Source := Source::Depot;
                            MouvTransaction."Code caisse" := rec."Code caisse";
                            MouvTransaction.Date := rec.Date;
                            MouvTransaction.Heure := rec.Heure;
                            MouvTransaction.Description := 'Annulation du dépot de: ' + rec."Nom du client";
                            MouvTransaction.Montant := -rec.Montant;
                            MouvTransaction."N° Document" := rec."N°";
                            MouvTransaction."Mode de reglement" := rec."Mode de paiement";
                            MouvTransaction."user id" := rec."User Id";
                            MouvTransaction."N° Client" := rec."N° client";
                            MouvTransaction.Insert();
                            rec.Validated := false;
                            rec.Modify();

                            commit();

                            reglementEntry2.SetRange("Journal Template Name", 'REGLEMENT');
                            reglementEntry2.SetRange("Journal Batch Name", Caisse."Code caisse");
                            if (reglementEntry2.FindLast()) then
                                LineNo := reglementEntry2."Line No." + 10000
                            else
                                LineNo := 10000;
                            reglementEntry.Reset();
                            reglementEntry."Journal Template Name" := 'REGLEMENT';
                            reglementEntry.Validate("Journal Template Name");
                            reglementEntry."Journal Batch Name" := Caisse."Code caisse";
                            reglementEntry.Validate("Journal Batch Name");
                            reglementEntry."Line No." := LineNo;
                            reglementEntry."Posting Date" := WorkDate;
                            reglementEntry.Validate("Posting Date");
                            reglementEntry."Document Type" := reglementEntry."Document Type"::Invoice;
                            reglementEntry.Validate("Document Type");
                            reglementEntry."Document No." := 'Depot' + rec."N°";
                            reglementEntry.Validate("Document No.");
                            reglementEntry."Account Type" := reglementEntry."Account Type"::"Customer";
                            reglementEntry.Validate("Account Type");
                            reglementEntry."Account No." := rec."N° client";
                            reglementEntry.Validate("Account No.");
                            reglementEntry.Description := 'Annulation Dépôt du client: ' + rec."Nom du client";
                            reglementEntry."Bal. Account Type" := reglementEntry."Bal. Account Type"::"Bank Account";
                            reglementEntry."Bal. Account No." := Caisse."Code caisse";
                            reglementEntry.Validate("Bal. Account No.");

                            reglementEntry.Amount := rec.Montant;
                            reglementEntry."Amount (LCY)" := rec."Montant";
                            reglementEntry.Validate(Amount);
                            reglementEntry."Debit Amount" := rec."Montant";
                            reglementEntry.Validate("Debit Amount");
                            reglementEntry.Insert();


                            reglementEntry3.Reset();
                            reglementEntry3.SetRange("Journal Template Name", 'REGLEMENT');
                            reglementEntry3.SetRange("Journal Batch Name", Caisse."Code caisse");
                            reglementEntry3.SetRange("Document No.", 'Depot' + rec."N°");
                            if (reglementEntry3.FindFirst()) then begin
                                Hide := true;
                                postLedger.OnBeforeCode(reglementEntry3, Hide);
                                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", reglementEntry3);
                            end;
                        end;
                    end;*/
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
    begin
        // Date := WorkDate;
        // Heure := Time;
        // "User Id" := UserId;
        Caisse.Reset();
        Caisse.SetRange("User ID", UserId);
        Caisse.FindFirst();
        //     "Code caisse" := Caisse."Code caisse";
        // CurrPage.Update();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Caisse.Reset();
        "User ID" := UserId;
        Caisse.SetRange("User ID", UserId);
        if (caisse.FindFirst()) then
            "Code Caisse" := caisse."Code caisse";
        Heure := time;
        Date := WorkDate;
        "Mode de paiement" := 'ESPÈCES'
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        if rec.validated = false then begin
            if Confirm('Vous n''anez pas validé le dépôt! Si vous sortez, le dépot sera supprimé. Voulez-vous sortir?') then begin
                rec.Delete();
                CurrPage.Close();
            end else
                Error('Veuillez validez le dépôt');
        end;
    end;

    var
        Caisse: Record Caisse;
        hide: Boolean;
        postLedger: Codeunit 70010;
        confirmSave: TextConst ENU = 'Would you like to save this transaction ?', FRA = 'Souhaitez-vous enregistrer cette transaction ?';
        cancelSave: TextConst ENU = 'Would you like to cancel this transaction ?', FRA = 'Souhaitez-vous annuler cette transaction ?';
}