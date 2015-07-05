﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CBeall.Mendham.Concurrency
{
	public class ConcurrencyException : InvalidOperationException
	{
		public ConcurrencyToken Expected { get; private set; }
		public ConcurrencyToken Actual { get; private set; }
		public string Entity { get; private set; }

		public ConcurrencyException(ConcurrencyToken expected, ConcurrencyToken actual, string entity, string message = null)
			: base(message)
		{
			this.Expected = expected;
			this.Actual = actual;
			this.Entity = entity;
		}

		public override string Message
		{
			get
			{
				string additionalInfo = String.Empty;

				if (!String.IsNullOrWhiteSpace(base.Message))
					additionalInfo = String.Format(" ADDITIONAL INFORMATION: {0}", base.Message);

				return String.Format("Concurrency exception on entity {0}. Expected: {1}, Actual: {2}.{3}",
					this.Entity,
					this.Expected,
					this.Actual,
					additionalInfo);
			}
		}
	}
}